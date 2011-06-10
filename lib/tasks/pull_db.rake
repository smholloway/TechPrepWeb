# http://devcenter.heroku.com/articles/taps#export_pull_from_heroku
# This pulls the contents (schema, data, indexes, sequences) of the remote Heroku database down into a local database specified in config/database.yml, or at the database URL provided as an argument as described in the previous section.
namespace :essandesstest do
	desc 'Pulls a heroku database'
	task :backup do
		# capture the backup bundle
		timestamp = `date -u '+%Y-%m-%d-%H-%M'`.chomp
		db_backup = "sqlite://essandesstest-#{timestamp}.db"
		puts "Capturing database #{db_backup}..."
		`heroku db:pull --confirm essandesstest '#{db_backup}'`

		# move the backup
		puts "Moving bundle to backups/#{db_backup}.dump"
		`mkdir -p backups`
		`mv '#{db_backup}' backups/'#{db_backup}'`
	end
end
