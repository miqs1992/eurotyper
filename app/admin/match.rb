# frozen_string_literal: true

ActiveAdmin.register Match do
  menu parent: "Matches"
  permit_params :match_day_id, :team1_id, :team2_id, :start_time,
                :score1, :score2, :finished

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :match_day
      f.input :team1
      f.input :team2
      f.input :start_time, as: :datetime_picker
      unless resource.new_record?
        f.input :score1
        f.input :score2
        f.input :finished
      end
    end
    f.actions
  end

  controller do
    def update
      update! do |format|
        format.html { redirect_to admin_match_day_path(resource.match_day_id), notice: 'Match updated!' } if resource.valid?
      end
    end
  end
end
