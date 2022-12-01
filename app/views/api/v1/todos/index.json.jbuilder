# frozen_string_literal: true

json.array!(@todos) do |todo|
  json.id todo[:id]
  json.content todo[:content]
  json.completed todo[:completed]
end
