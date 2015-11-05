class Project < ActiveRecord::Base
	# Each project have some tasks
	# Each task is a small thing that should be done in the project.
	has_many :tasks, dependent: :destroy
	
	# Attach image to a project
	has_attached_file :image_file, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	# Check if the image file's name is valid
	validates_attachment_content_type :image_file, :content_type => /\Aimage\/.*\Z/

	# Impossible to create a task without a title
	validates(:title, presence:true)
	TITLE_MAX_LENGTH = 60 # Characters
	TITLE_MIN_LENGTH = 3  # Characters
	validates(:title, lenght: { in: TITLE_MIN_LENGTH...TITLE_MAX_LENGTH })

	# Impossible to create a task without a description
	validates(:description, presence: true)
	DESCRIPTION_MAX_LENGTH = 20 # Characters
	DESCRIPTION_MIN_LENGTH = 10000 # Characters
	validates(:description, length: { in: DESCRIPTION_MIN_LENGTH...DESCRIPTION_MAX_LENGTH })

  # Impossible to create a project without difficult setting
  validates(:percentage, presence: true)
  # Accept only numbers for difficult
  validates(:percentage, numericality: { only_integer: true })
  # Percentage values should not be out of range (0%,100%)
  validates_inclusion_of(:percentage, in: 0...100)

  # Impossible to create a project without a level
  validates(:level, presence: true)
  # Only 3 types of level are permitted
  PERMITTED_LEVELS = w%(easy medium hard)
  validates(:level, inclusion: PERMITTED_LEVELS)

  # Impossible to create a project without a category
  validates(:category, presence: true)
  CATEGORY_MAX_LENGTH = 30 # Characters
  CATEGORY_MIN_LENGTH = 4 # Characters
  validates(:category, length: { in: CATEGORY_MIN_LENGTH...CATEGORY_MAX_LENGTH})

  # Impossible to create a project without a status
  validates(:status, presence: true)
  # Only 3 types of level are permitted
  PERMITTED_STATUS = w%(active stopped finished)
  validates(:status, inclusion: PERMITTED_STATUS)

end
