# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :certification, :class => 'Certifications' do
    name "MyString"
  end
end
