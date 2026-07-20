script_folder="/d/Agile_Robot/tech_challenge_rt/test_package/build/gcc-11-x86_64-20-release/generators"
echo "echo Restoring environment" > "$script_folder/deactivate_conanrunenv-release-x86_64.sh"
for v in PATH LD_LIBRARY_PATH DYLD_LIBRARY_PATH
do
   is_defined="true"
   value=$(printenv $v) || is_defined="" || true
   if [ -n "$value" ] || [ -n "$is_defined" ]
   then
       echo export "$v='$value'" >> "$script_folder/deactivate_conanrunenv-release-x86_64.sh"
   else
       echo unset $v >> "$script_folder/deactivate_conanrunenv-release-x86_64.sh"
   fi
done

export PATH="/home/fahad471/.conan2/p/b/chall47cf0ddfe6c88/p/bin${PATH:+:$PATH}"
export LD_LIBRARY_PATH="/home/fahad471/.conan2/p/b/chall47cf0ddfe6c88/p/lib:/home/fahad471/.conan2/p/b/boostd704b3ba5e276/p/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export DYLD_LIBRARY_PATH="/home/fahad471/.conan2/p/b/chall47cf0ddfe6c88/p/lib:/home/fahad471/.conan2/p/b/boostd704b3ba5e276/p/lib${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}"