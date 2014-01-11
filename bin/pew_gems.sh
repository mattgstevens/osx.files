# extend so that it will stomp the global gemset of the current ruby version
gem list | cut -d " " -f1 | xargs gem uninstall -aIx
