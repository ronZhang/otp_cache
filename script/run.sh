#!/bin/sh
cd ../ebin
erl   -boot start_sasl -config log  -s simple_cache load_applications 