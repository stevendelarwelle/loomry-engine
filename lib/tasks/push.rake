task :push, [:msg] do |t, args| 
puts "## Adding all files (git add .)" 
system("git add --all") 
# Handle commas in commit messages 
commit_msg = args.to_a.join(', ') 
puts "## Committing chgnges (git commit -m '#{commit_msg}')" 
system("git commit -m '#{commit_msg}'") 
puts "## Pushing to Github (git push)" 
system("git push -u origin master") 
end 