#!/bin/bash
ocamljava str.cmja dir.ml -o count-lines.jar main.ml && java -jar count-lines.jar