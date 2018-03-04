require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @auth_token = self.class.post('/sessions', body: {"email": email,"password": password})["auth_token"]
    if @auth_token.nil?
      p "Authentication incorrect"
    else
      p "Auth worked"
    end
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_messages(page = nil)
    if page.nil?
      response = self.class.get("/message_threads", headers: { "authorization" => @auth_token })
    else
      response = self.class.get("/message_threads", body: {"page": page}, headers: { "authorization" => @auth_token })
    end
    JSON.parse(response.body)
  end

  def create_message(email, recipient_id, subject, body)
    response = self.class.post("/messages",
    values: {
      "sender": email,
      "recipient_id": recipient_id,
      "subject": subject,
      "stripped-text": body
      },
    headers: { "authorization" => @auth_token })
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    response = self.class.post("/checkpoint_submissions",
    values: {
      "enrollment_id": 38437,
      "checkpoint_id": checkpoint_id,
      "assignment_branch": assignment_branch,
      "assignment_commit_link": assignment_commit_link,
      "comment": comment
      },
    headers: { "authorization" => @auth_token })
  end
end
