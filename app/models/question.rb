class Question < ActiveRecord::Base
	# https://github.com/mbleigh/acts-as-taggable-on
	# Alias for <tt>acts_as_taggable_on :tags</tt>:
	#acts_as_taggable
	acts_as_taggable_on :tags

	validates_presence_of :front, :back, :raw
end
