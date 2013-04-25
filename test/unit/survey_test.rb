require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  def setup
    @survey = Fabricate(:survey)
  end

  test 'create' do
    assert_difference ['Survey.count', 'Version.count'] do
      assert Survey.create(Fabricate.attributes_for(:survey))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Survey.count' do
        assert @survey.update_attributes(firstname: 'Updated')
      end
    end

    assert_equal 'Updated', @survey.reload.firstname
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('Survey.count', -1) { @survey.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @survey.firstname = ''
    @survey.lastname = ''
    @survey.identification = ''
    @survey.email = ''
    
    assert @survey.invalid?
    assert_equal 4, @survey.errors.size
    assert_equal [error_message_from_model(@survey, :firstname, :blank)],
      @survey.errors[:firstname]
    assert_equal [error_message_from_model(@survey, :lastname, :blank)],
      @survey.errors[:lastname]
    assert_equal [error_message_from_model(@survey, :identification, :blank)],
      @survey.errors[:identification]
    assert_equal [error_message_from_model(@survey, :email, :blank)],
      @survey.errors[:email]
  end
    
  test 'validates unique attributes' do
    new_survey = Fabricate(:survey)
    @survey.lastname = new_survey.lastname
    @survey.identification = new_survey.identification

    assert @survey.invalid?
    assert_equal 1, @survey.errors.size
    assert_equal [error_message_from_model(@survey, :identification, :taken)],
      @survey.errors[:identification]
  end
end
