require 'spec_helper'

describe Comment do
  let(:question){Question.create!(question_text: "Why?", user_id: 0)}
  let(:answer){Answer.create!(answer_text: "Because.", question_id: question.id, user_id: 0)}
  let(:comment_on_question){Comment.create!(commentable_id: question.id, commentable_type: 'Question', comment_text: "I don't get it.", user_id: 0)}
  let(:comment_on_answer){Comment.create!(commentable_id: answer.id, commentable_type: 'Answer', comment_text: "Bad answer.", user_id: 0)}

  describe "attributes" do
    it "has comment text" do
      expect(comment_on_question.comment_text).to eq("I don't get it.")
    end
    it "has a commentable id" do
      expect(comment_on_question.commentable_id).to eq(question.id)
    end
    it "has a commentable type" do
      expect(comment_on_question.commentable_type).to eq("Question")
    end
    it "has a user id" do
      expect(comment_on_question.user_id).to eq(0)
    end
  end

  describe 'associations' do
    it "belongs to a question" do
      expect(comment_on_question.commentable).to eq(question)
    end
    it "belongs to an answer" do
      expect(comment_on_answer.commentable).to eq(answer)
    end

  end
end
