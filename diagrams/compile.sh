#!/bin/bash
cd "$(dirname "$0")"
plantuml *.pu -latex:nopreamble
