require File.dirname(__FILE__) + '/test_helper.rb'

class TestTweetPoller < Test::Unit::TestCase

  def setup
    @app = TweetTail::TweetPoller.new('jaoo')
    @app.expects(:initial_json_data).returns(<<-JSON)
    {
        "results": [{
            "text": "reading my own abstract for JAOO presentation",
            "from_user": "drnic",
            "id": 1666627310
        },{
            "text": "Come speak with Matt at JAOO next week",
            "from_user": "theRMK",
            "id": 1666334207
        },{
            "text": "@VenessaP I think they went out for noodles. #jaoo",
            "from_user": "Steve_Hayes",
            "id": 1666166639
        },{
            "text": "Come speak with me at JAOO next week - http:\/\/jaoo.dk\/",
            "from_user": "mattnhodges",
            "id": 1664823944
        }],
        "refresh_url": "?since_id=1682666650&q=jaoo"
    }
    JSON
    @app.refresh
  end
  
  def test_found_results
    assert_equal(4, @app.latest_results.length)
  end
  
  def test_message_render
    expected = <<-RESULTS.gsub(/^    /, '')
    mattnhodges: Come speak with me at JAOO next week - http://jaoo.dk/
    Steve_Hayes: @VenessaP I think they went out for noodles. #jaoo
    theRMK: Come speak with Matt at JAOO next week
    drnic: reading my own abstract for JAOO presentation
    RESULTS
    assert_equal(expected, @app.render_latest_results)
  end
  
  def test_ready_for_refresh
    assert_equal('?since_id=1682666650&q=jaoo', @app.refresh_url)
  end
  
  def test_refresh_data
    @app.expects(:refresh_json_data).returns(<<-JSON)
    {
      "results": [{
        "text": "Wish I could be at #JAOO Australia...",
        "from_user": "CaioProiete",
        "id": 1711269079
      }],
      "refresh_url": "?since_id=1711269079&q=jaoo"
    }
    JSON
    @app.refresh
    expected = <<-RESULTS.gsub(/^    /, '')
    CaioProiete: Wish I could be at #JAOO Australia...
    RESULTS
    assert_equal(expected, @app.render_latest_results)
    assert_equal('?since_id=1711269079&q=jaoo', @app.refresh_url)
  end
end
