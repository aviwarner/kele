module Roadmap
  def get_roadmap(roadmap_id)
    response = self.class.get("/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    response = self.class.post("/checkpoint_submissions",
    values: {
      "enrollment_id": 38437,
      "checkpoint_id": checkpoint_id, #2555
      "assignment_branch": assignment_branch, #"submissions"
      "assignment_commit_link": assignment_commit_link, #https://github.com/aviwarner/kele/commit/2feadad6fc03dd015cd2f6973345dd783f107e2d
      "comment": comment,
      },
    headers: { :content_type => 'application/json', :authorization => @auth_token })
    puts response
  end
end
