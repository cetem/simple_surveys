require 'test_helper'

class TravelLineTest < ActiveSupport::TestCase
  def setup
    @travel_line = Fabricate(:travel_line)
  end

  test 'create' do
    assert_difference ['TravelLine.count', 'Version.count'] do
      assert TravelLine.create(
        Fabricate.attributes_for(:travel_line, survey_id: @travel_line.survey_id)
      )
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'TravelLine.count' do
        assert @travel_line.update_attributes(travel_days: 'Monday')
      end
    end

    assert_equal 'Monday', @travel_line.reload.travel_days
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('TravelLine.count', -1) { @travel_line.destroy }
    end
  end
end
