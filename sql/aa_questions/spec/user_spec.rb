require 'rspec'
require_relative '../lib/user' 
require_relative '../lib/questions_database'

describe User do

  before(:each) { QuestionsDatabase.instance.reset! }
  after(:each) { QuestionsDatabase.instance.reset! }

  describe '::find_by_id' do 
    it 'returns an instance of the user class' do
      reply = described_class.find_by_id(1)
      expect(reply).to be_kind_of(described_class)
    end 
    
    it 'returns a user with the correct id' do 
      reply = described_class.find_by_id(1)
      expect(reply.id).to eq(1)
    end 
  end

  describe '::find_by_name' do
    it 'returns an instance of the user class' do
      reply = described_class.find_by_name("Wann", "Dax")
      expect(reply.first).to be_kind_of(described_class)
    end 
    
    it 'returns the correct fname and lname' do 
      reply = described_class.find_by_name("Poehler", "Amy")
      expect(reply.first.fname).to eq("Amy")
      expect(reply.first.lname).to eq("Poehler")
    end
  end 
 
  describe '#save' do 
    let(:user) {described_class.new( {'lname' => "test_fname", 'fname' => "test_lname"}) }
    
    it 'persists a new user to the database' do 
      user.save
      expect(described_class.find_by_id(5)).to be_truthy 
    end 
    
    it "persists an updated user to the database" do 
      user.save
      user.fname = "updated_fname"
      user.save
      expect(described_class.find_by_id(5).fname).to eq("updated_fname")
    end 
  end 
 
  describe '#authored_questions' do 
    subject(:user) { described_class.find_by_id(1) }
    let(:question) { class_double("Question").as_stubbed_const }
    
    it 'calls Question::find_by_author_id' do
      expect(question).to receive(:find_by_author_id).with(user.id)
      user.authored_questions 
    end 
  end 
 
  describe '#followed_questions' do 
    subject(:user) { described_class.find_by_id(1) }
    let(:questionfollow) { class_double("QuestionFollow").as_stubbed_const }
    
    it 'calls QuestionFollow::followed_questions_for_user_id' do 
      expect(questionfollow).to receive(:followed_questions_for_user_id).with(user.id)
      user.followed_questions
    end 
  end
 
  describe '#authored_replies' do 
    subject(:user) { described_class.find_by_id(1) }
    let(:reply) { class_double("Reply").as_stubbed_const }

    it 'calls Reply::find_by_user_id' do 
      expect(reply).to receive(:find_by_user_id).with(1)
      user.authored_replies
    end 
  end

  describe '#liked_questions' do 
    subject(:user) { described_class.find_by_id(1) }
    let(:questionlike) { class_double("QuestionLike").as_stubbed_const }

    it 'calls QuestionLike::liked_questions_for_user_id' do 
      expect(questionlike).to receive(:liked_questions_for_user_id).with(user.id)
      user.liked_questions
    end
  end

  describe "#average_karma" do 
    it 'returns the correct average karma for a user' do 
      user = described_class.find_by_id(1)
      expect(user.average_karma).to eq(3.0)
    end
  end 
end
