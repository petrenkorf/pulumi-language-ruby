# pulumi-language-ruby

**Ruby runtime for Pulumi** – allows running Pulumi programs written in Ruby using the Pulumi CLI.

This project implements a custom Pulumi language runtime for Ruby. It communicates with the Pulumi engine via gRPC and enables you to write infrastructure-as-code programs in pure Ruby.

---

## Features

- Run Ruby Pulumi programs using the Pulumi CLI.
- Vendored Pulumi proto definitions for gRPC communication.
- Supports resource registration via a Ruby SDK.
- Works with any Pulumi-supported provider, e.g., AWS, Azure, GCP.

---

## Installation

This repository contains the language runtime itself. You can install it system-wide for testing:

```bash
git clone https://github.com/<your-org>/pulumi-language-ruby.git
cd pulumi-language-ruby
chmod +x bin/pulumi-language-ruby
sudo cp bin/pulumi-language-ruby /usr/local/bin/
