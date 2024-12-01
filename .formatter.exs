locals_without_parens = [
  field: 3,
  field: 2,
  add: 3,
  add: 2,
  create: 1,
  execute: 2,
  belongs_to: 2,
  belongs_to: 3,
  has_many: 2,
  has_many: 3,
  has_one: 2,
  many_to_many: 2,
  references: 2,
  from: 2
]

[
  plugins: [Styler, Phoenix.LiveView.HTMLFormatter],
  inputs: [".credo.exs", ".formatter.exs", "mix.exs", "{config,lib,priv,test}/**/*.{ex,exs}"],
  locals_without_parens: locals_without_parens
]
