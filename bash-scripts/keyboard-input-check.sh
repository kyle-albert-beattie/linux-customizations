#!/bin/bash
# Description
# This script will check the input of our keyboard keys and display their name.
xev | sed -n 's/[ ]*state.* \([^ ]*\)).*/\1/p'


