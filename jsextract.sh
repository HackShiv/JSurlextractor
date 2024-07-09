#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 -f <file_containing_js_urls> [-o <output_file>]"
  exit 1
}

# Function to extract endpoints from JS file content
extract_endpoints() {
  local url="$1"
  local temp_file=$(mktemp)

  # Fetch the JS file content and save to a temporary file
  curl -s -o "$temp_file" "$url"

  # Ensure the content was fetched
  if [[ ! -s "$temp_file" ]]; then
    echo "Failed to fetch content from $url"
    rm -f "$temp_file"
    return
  fi

  # Search for URLs and endpoints, filter out comments, irrelevant lines, and extract paths
  echo "Analyzing $url for URLs and endpoints"
  grep -o -E 'https?://[^/"]+(/[^\s"]*)*' "$temp_file" | \
    sed -E 's/#[^"]*//' | \
    sed -E 's/\?.*//' | \
    sort -u

  # Remove the temporary file
  rm -f "$temp_file"

  # Optional: Add a separator for better readability
  echo "--------------------------------------------------------------"
}

# Parse command-line arguments
output_file=""
while getopts "f:o:" opt; do
  case $opt in
    f) URL_FILE="$OPTARG" ;;
    o) output_file="$OPTARG" ;;
    *) usage ;;
  esac
done

# Check if the URL file is specified and exists
if [[ -z "$URL_FILE" || ! -f "$URL_FILE" ]]; then
  usage
fi

# Check if output file is specified and writable
if [[ -n "$output_file" ]]; then
  touch "$output_file" || { echo "Error: Unable to write to output file $output_file"; exit 1; }
fi

# Read URLs from the file and process each one
while IFS= read -r url; do
  extract_endpoints "$url"
done < "$URL_FILE" | tee "$output_file"

echo "Endpoint extraction complete. Check the output above for URLs and endpoints."

