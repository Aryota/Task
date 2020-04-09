class Task < ApplicationRecord
  paginates_per 50
  def self.csv_attributes
    ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end

  has_one_attached :image
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validate :validate_name_not_including_comma

  scope :recent, -> { order(created_at: :desc) }

  enum priority: { low: 0, medium: 1, high: 2 }
  enum completed: { 未完了: 0, 完了: 1 }

  private

  def validate_name_not_including_comma
      errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
