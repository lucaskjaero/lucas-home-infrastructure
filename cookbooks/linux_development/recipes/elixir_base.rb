#
# Cookbook:: linux_development
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe["elixir"]

atom_apm "atom-elixir"
atom_apm "atom-elixir-formatter"
atom_apm "language-elixir"
