json.array! @subjects do |subject|
  json.id subject.id
  json.name subject.name
  json.subject_type subject.subject_type
end
