#!/usr/bin/sh

grpc_tools_ruby_protoc --proto_path=. \
  --ruby_out=./lib/ruby_pulumi/generated \
  --grpc_out=./lib/ruby_pulumi/generated \
  $(find proto -name "*.proto")
