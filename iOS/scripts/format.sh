#!/bin/sh
# SwiftFormat
# rules here: https://github.com/nicklockwood/SwiftFormat/blob/master/Rules.md

cd `git rev-parse --show-toplevel`
cd iOS/
"./Pods/SwiftFormat/CommandLineTool/swiftformat" "./" \
--exclude Carthage,Pods,**/*.generated.swift \
--stripunusedargs closure-only \
--disable strongOutlets,numberFormatting,emptyBraces,andOperator