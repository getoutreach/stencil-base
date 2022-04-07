# HACK(jaredallard): Remove when stencil-base is cleaned up
APP := stencil-base
OSS := true

_ := $(shell ./scripts/devbase.sh) 

include .bootstrap/root/Makefile