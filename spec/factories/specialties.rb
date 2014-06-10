# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specialty, :class => 'Specialties' do
    name "MyString"
  end
end
