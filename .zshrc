if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi



export GLM_INCLUDE_DIR=/Users/rudolfkischer/MCGILL/COMP557/Workspace/glm
export GLFW_DIR=/Users/rudolfkischer/MCGILL/COMP557/Workspace/glfw
export GLEW_DIR=/Users/rudolfkischer/MCGILL/COMP557/Workspace/glew-2.1.0


export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/rudolfkischer/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/rudolfkischer/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/rudolfkischer/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/rudolfkischer/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/rudolfkischer/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/rudolfkischer/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export MODULAR_HOME="/Users/rudolfkischer/.modular"
export PATH="/Users/rudolfkischer/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

 
# ======== Random fact title ===========
# Fetch fact from the new APIv2 endpoint
response=$(curl -s "https://uselessfacts.jsph.pl/api/v2/facts/random?language=en")

# Check if the response is valid JSON
if echo "$response" | jq empty 2>/dev/null; then
  fact=$(echo "$response" | jq -r '.text')
else
  fact="Could not retrieve fact."
fi

# Update the terminal title with the fact or fallback message
echo -ne "\033]0;$fact\007"
# ========================================





#============================PROMPT SETTINGS====================================

autoload -U colors && colors

# Define color codes
RED="%F{red}"
GREEN="%F{green}"
YELLOW="%F{yellow}"
BLUE="%F{blue}"
MAGENTA="%F{magenta}"
CYAN="%F{cyan}"
RESET="%f"

COLOR_GRADIENT=("red" "yellow" "green" "cyan" "blue" "magenta")

function current_song {
  local song=$(osascript -e 'tell application "Spotify"
      if it is running then
          if player state is playing then
              artist of current track & " - " & name of current track
          else
              return "Spotify is not playing"
          end if
      else
          return "Spotify is not running"
      end if
  end tell' 2>/dev/null)
  
  if [[ -n $song ]]; then
    echo "🎵 $song"
  else
    echo ""
  fi
}

function moon_phase {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    local new_moon_date=$(date -j -f "%Y-%m-%d" "2000-01-06" "+%s")
  else
    local new_moon_date=$(date -d "2000-01-06" "+%s")
  fi

  local current_date=$(date "+%s")
  local phase_length=2551443  # Length of moon cycle in seconds

  # Check if the dates are valid numbers
  if [[ -z "$new_moon_date" || -z "$current_date" || ! "$new_moon_date" =~ ^[0-9]+$ || ! "$current_date" =~ ^[0-9]+$ ]]; then
    echo "🌑"  # Default to New Moon if there's an error
    return
  fi

  # Safely handle math operations
  local diff=$(( (current_date - new_moon_date) % phase_length ))
  if (( diff < 0 )); then
    diff=$(( diff + phase_length ))
  fi
  local phase=$(( (diff * 8 + phase_length / 2) / phase_length % 8 ))

  # Return the correct moon phase symbol
  case $phase in
    0) echo "🌑" ;; # New Moon
    1) echo "🌒" ;; # Waxing Crescent
    2) echo "🌓" ;; # First Quarter
    3) echo "🌔" ;; # Waxing Gibbous
    4) echo "🌕" ;; # Full Moon
    5) echo "🌖" ;; # Waning Gibbous
    6) echo "🌗" ;; # Last Quarter
    7) echo "🌘" ;; # Waning Crescent
  esac
}

# Array of different prompt strings
setopt PROMPT_SUBST

# Function to get the current git branch (if in a git repository)
git_branch_prompt() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        echo "[$branch]"
    fi
}

# Array of different prompt strings with increasing verbosity
PROMPT_LIST=(
    '[%1~]'    # 1. Current folder name
    '[%1~]$(git_branch_prompt)'                    # 2. Adding current git branch
    '[%~]$(git_branch_prompt)'                     # 3. Adding current folder path
    '[%*][%~] $(git_branch_prompt)'                  # 4. Adding current time
    '[%D{%Y-%m-%d}|%*][%~]$(git_branch_prompt)'     # 5. Adding current date
    '[%n][%D{%Y-%m-%d}|%*][%~]$(git_branch_prompt)'  # 6. Adding current user
    '$(current_song)'
)

# Current index for the prompt list
PROMPT_INDEX=1

# Function to apply the current prompt based on the index
apply_prompt() {

	PROMPT="${PROMPT_LIST[PROMPT_INDEX]} $(moon_phase)> "
}


# Function to toggle through the list of prompts
function toggle_prompt() {
	PROMPT_INDEX=$(( PROMPT_INDEX % ${#PROMPT_LIST[@]} + 1 ))
   	apply_prompt
	zle reset-prompt	
}

# Define the toggle_prompt function as a Zsh widget
zle -N toggle_prompt

# Start with the first prompt (non-verbose by default)
apply_prompt

# Example keybinding to toggle through prompts (bind it to your preferred key combo)
bindkey "^[V" toggle_prompt
#=========================================================================


# THIS MUST BE PUT AT THE END OF THIS FILE FOR IT TO WORK PROPERLY
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
