#!/bin/bash

DIR="/home/joaolucas/Downloads"

criar_pasta(){
    if [! -d "$1" ]; then
        mkdir "$1"
    fi
}