namespace :essandesstest do
	desc 'Captures a heroku backup'
	task :backup do
		# capture the backup bundle
		timestamp = `date -u '+%Y-%m-%d-%H-%M'`.chomp
		bundle_name = "essandesstest-#{timestamp}"
		puts "Capturing bundle #{bundle_name}..."
		`heroku pgbackups:capture --app essandesstest '#{bundle_name}'`

		# download & destroy the bundle we just captured
		puts "Downloading bundle #{bundle_name}.dump"
		backup_url = `heroku pgbackups:url`
		`curl -o '#{bundle_name}'.dump '#{backup_url}'`

		# move the backup
		puts "Moving bundle to backups/#{bundle_name}.dump"
		`mkdir -p backups`
		`mv '#{bundle_name}'.dump backups/#{bundle_name}.dump`
	end
end
