#!/bin/bash

# Execute all scripts inside my_init folder

if [ $(ls | wc -l) -eq 0 ]; then 
  return
else
  ls /etc/my_init.d/*.sh | xargs bash
fi
