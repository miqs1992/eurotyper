# frozen_string_literal: true

json.players @players do |player|
  json.extract! player, :id, :name, :position, :goals
  json.team do
    json.name player.team.name
    json.flag player.team.flag
  end
end
