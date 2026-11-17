#!/bin/bash

# Script to apply all 'flm' prefixed patches in the current directory's 'patches' folder
# onto a submodule directory (assumed to be at ./submodule or specified via SUBMODULE_DIR)

set -e  # Exit on error

PATCHES_DIR="${1:-./patches}"
SUBMODULE_DIR="${2:-./fastflowlm}"

echo "Applying patches from: $PATCHES_DIR"
echo "Target submodule directory: $SUBMODULE_DIR"
echo ""

# Check if patches directory exists
if [ ! -d "$PATCHES_DIR" ]; then
    echo "Error: Patches directory '$PATCHES_DIR' does not exist." >&2
    exit 1
fi

# Check if submodule directory exists (create it if needed)
if [ ! -d "$SUBMODULE_DIR" ]; then
    echo "Submodule directory '$SUBMODULE_DIR' does not exist. Creating..." >&2
    mkdir -p "$SUBMODULE_DIR" || { echo "Failed to create submodule directory." >&2; exit 1; }
fi

# Find all patch files starting with 'flm' (case-insensitive)
PATCH_FILES=$(ls -1 "$PATCHES_DIR"/flm*.patch 2>/dev/null | sort)

if [ -z "$PATCH_FILES" ]; then
    echo "No patch files found matching pattern 'flm*.patch' in '$PATCHES_DIR'" >&2
    exit 0
fi

echo "Found patches to apply:"
echo "$PATCH_FILES" | while read -r f; do echo "  -> $f"; done
echo ""

# Apply each patch file with context and reject empty ones
FAILED=0

for PATCH_FILE in $PATCH_FILES; do
    REL_PATCH_PATH=$(basename "$PATCH_FILE")
    
    # Skip if not a regular file or too large (safety check)
    if [ ! -f "$PATCH_FILE" ]; then
        continue
    fi
    
    # Check patch size to avoid applying huge patches silently
    PATCH_SIZE=$(wc -c < "$PATCH_FILE")
    
    echo "Applying: $REL_PATCH_PATH ($PATCH_SIZE bytes)"
    
    if git apply --check "$PATCH_FILE"; then
        # Patch can be applied cleanly, show preview first (optional but helpful)
        git apply --verbose "$PATCH_FILE" || { 
            echo "  Failed to apply patch. Retrying with -3 for context..." >&2 
            git apply -3 --verbose "$PATCH_FILE" || {
                echo "  Error applying $REL_PATCH_PATH" >&2
                FAILED=1
            }
        }
    else
        # Patch needs manual intervention or has conflicts, try with more options first (from StackOverflow)
        if ! git apply -3 --verbose "$PATCH_FILE"; then 
            echo "  Warning: Could not cleanly apply $REL_PATCH_PATH. Manual review may be needed." >&2
            
            # Try to show what would be applied
            git apply --stat "$PATCH_FILE" || true
            
            FAILED=1
        fi
    fi
    
    echo ""
done

if [ $FAILED -eq 1 ]; then
    echo "Some patches failed to apply. Please review the errors above." >&2
else
    echo "All 'flm' prefixed patches applied successfully!" >&2
fi