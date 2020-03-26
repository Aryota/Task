require 'rails_helper'

RSpec.describe Task, type: :model do
  it "returns true" do
    expect(Task.maximum_size).to eq 50 
    expect(Task.new().size).to eq 20
    
  end
  it "returns nice" do
    # expect(Task.days).to eq first_task "勤怠"
    10
  end

end
