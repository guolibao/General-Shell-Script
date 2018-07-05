dir=$(pwd)
echo ${dir}

printf "\n\ngrep for JK_LOG_GUO\n" \
&& grep -rl --color=always --include=*.cpp --include=*.h JK_LOG_GUO ${dir} \
&& printf "\n\ngrep for JK_LOG_LI\n" \
&& grep -rl --color=always --include=*.cpp --include=*.h JK_LOG_LI ${dir} \
&& printf "\n\ngrep for JK_LOG_BAO\n" \
&& grep -rl --color=always --include=*.cpp --include=*.h JK_LOG_BAO ${dir} \
&& printf "\n\ngrep for JK_LOG_ZHANG\n" \
&& grep -rl --color=always --include=*.cpp --include=*.h JK_LOG_ZHANG ${dir} \
&& printf "\n\ngrep for JK_LOG_YU\n" \
&& grep -rl --color=always --include=*.cpp --include=*.h JK_LOG_YU ${dir}

