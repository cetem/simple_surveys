Fabricator(:survey) do
  firstname             { Faker::Name.first_name }
  lastname              { Faker::Name.last_name }
  identification        { |attrs| [attrs[:firstname], attrs[:lastname], rand(99)].join('-') }
  phone                 { Faker::PhoneNumber.cell_phone }
  email                 { Faker::Internet.email }
  institution           { Faker::Lorem.word }
  status_in_institution { Faker::Lorem.word }
  
  travel_lines_attributes {[Fabricate.attributes_for(:travel_line, survey_id: nil)] }
end
