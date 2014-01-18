#!/bin/bash
cd ../ebin
erl -name sd1@127.0.0.1  -s sc_app load_application 
