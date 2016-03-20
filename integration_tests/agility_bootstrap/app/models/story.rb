class Story < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title  :string
    body   :markdown # or :textile
    color  Color, :default => "#000000"
    timestamps
  end

  belongs_to :project, :inverse_of => :stories
  belongs_to :status, :class_name => "StoryStatus"

  has_many :tasks, :dependent => :destroy, :accessible => true

  attr_accessible :title, :body, :color, :tasks, :status, :status_id

  children :tasks

  # --- Permissions --- #

  def create_permitted?
    project ? project.creatable_by?(acting_user) : true
  end

  def update_permitted?
    project ? project.updatable_by?(acting_user) : true
  end

  def destroy_permitted?
    project ? project.destroyable_by?(acting_user) : true
  end

  def view_permitted?(field)
    project ? project.viewable_by?(acting_user) : true
  end

end
