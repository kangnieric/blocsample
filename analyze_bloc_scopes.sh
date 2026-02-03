#!/bin/bash

# --- Singleton Candidate Detector ---
# This script analyzes BLoCs to suggest if they should be singletons.
# It checks for keywords indicating long-lived state or resource management.

# Directory to search for BLoCs
BLOC_DIR="lib/blocs"

# Keywords that suggest a class manages long-lived resources
KEYWORDS=("StreamSubscription" "Timer" "Socket")

echo "🔎 Analyzing BLoC scopes in '$BLOC_DIR'..."
echo "-------------------------------------------------"

# Use find to get all .dart files and loop through them
find "$BLOC_DIR" -type f -name "*_bloc.dart" | while read -r file; do
  echo "Processing file: $file"
  # Extract the class name, assuming it matches the file name convention
  CLASS_NAME=$(basename "$file" .dart | sed -E 's/(^|_)./ \U&/g' | sed 's/ //g' | sed 's/_//g')

  # --- CHECK 1: Does it manage long-lived resources? ---
  MANAGES_RESOURCE=false
  for keyword in "${KEYWORDS[@]}"; do
    if grep -q "$keyword" "$file"; then
      MANAGES_RESOURCE=true
      break
    fi
  done

  # --- CHECK 2: What is its current annotation? ---
  IS_SINGLETON=$(grep -E "@singleton|@lazySingleton" "$file")
  IS_FACTORY=$(grep -q "@factory" "$file")

  # --- REPORTING ---
  if [ "$MANAGES_RESOURCE" = true ]; then
    echo "File: $file"
    echo "Class: $CLASS_NAME"
    
    if [ -n "$IS_SINGLETON" ]; then
      echo "✅ ASSESSMENT: CORRECT. Manages resources and is correctly marked as a singleton."
    elif [ "$IS_FACTORY" = true ]; then
      echo "❌ ASSESSMENT: INCORRECT. Manages resources but is marked as @factory. This will cause resource leaks or bugs. Should be @lazySingleton."
    else
      echo "⚠️ FOR REVIEW: Manages resources but has no scope annotation. Recommend using @lazySingleton."
    fi
    echo "-------------------------------------------------"
  fi
done

echo "✨ Analysis complete."