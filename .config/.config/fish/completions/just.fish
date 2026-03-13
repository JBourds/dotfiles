# Fish completion for just
# Dynamically generates completions based on justfile(s) in current directory

function __just_complete_recipes
    # Use just --list which automatically searches parent directories
    # Suppress stderr to avoid error messages during completion
    set -l output (just --list 2>/dev/null)
    
    if test $status -ne 0
        return 1
    end
    
    # Parse output line by line
    set -l in_recipes false
    for line in $output
        # Skip header line
        if string match -q "Available recipes:*" "$line"
            set in_recipes true
            continue
        end
        
        if test "$in_recipes" = true
            # Parse line format: "    recipe-name args... # Description"
            # Lines start with spaces, then recipe name, then optional args, then optional # description
            
            # Extract recipe name (first word after leading whitespace)
            # Use string replace to extract just the recipe name
            set -l recipe_name (string replace -r '^\s+(\S+).*' '$1' "$line")
            
            # Skip if we didn't extract a valid recipe name
            if test -z "$recipe_name" -o "$recipe_name" = "$line"
                continue
            end
            
            # Extract description (everything after #)
            set -l description (string replace -r '^.*#\s*(.+)$' '$1' "$line")
            
            # If description extraction didn't change the line, there's no description
            if test "$description" = "$line"
                set description ""
            end
            
            # Output completion with description
            if test -n "$description"
                printf "%s\t%s\n" "$recipe_name" "$description"
            else
                echo "$recipe_name"
            end
        end
    end
end

# Complete just command
complete -c just -f -a "(__just_complete_recipes)"

# Complete just command options
complete -c just -s f -l justfile -r -d "Use <justfile> as justfile"
complete -c just -s c -l command -r -d "Run an arbitrary command"
complete -c just -s d -l directory -r -d "Change working directory to <dir> before executing recipes"
complete -c just -s s -l shell -r -d "Invoke <shell> to run recipes"
complete -c just -l shell-arg -r -d "Invoke shell with <shell-arg> as an argument"
complete -c just -s e -l edit -d "Edit justfile with $EDITOR"
complete -c just -l evaluate -d "Print evaluated justfile"
complete -c just -l init -d "Initialize new justfile in current directory"
complete -c just -s l -l list -d "List available recipes"
complete -c just -l list-all -d "List all recipes including hidden ones"
complete -c just -l show -r -d "Show information about <recipe>"
complete -c just -s u -l unsorted -d "List recipes in source order"
complete -c just -s q -l quiet -d "Suppress all output"
complete -c just -s v -l verbose -d "Use verbose output"
complete -c just -l color -x -a "auto always never" -d "Print colorful output"
complete -c just -l no-dotenv -d "Don't load .env file"
complete -c just -l dump -d "Print justfile"
complete -c just -l fmt -d "Format and overwrite justfile"
complete -c just -l check -d "Check justfile syntax"
complete -c just -l highlight -d "Highlight justfile"
complete -c just -l changelog -d "Print changelog"
complete -c just -l clear-shell-args -d "Clear shell arguments"
complete -c just -s h -l help -d "Print help information"
complete -c just -s V -l version -d "Print version information"
