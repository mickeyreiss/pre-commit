Pod::Spec.new do |s|
  s.name         = "pre-commit"
  s.version      = "0.1.0"
  s.summary      = "Automatically install a git pre-commit hook."
  s.description  = <<-DESC
                    Automatically install a pre-commit hook from your working directory.

                    * Ensure that code is always linted and tested before checking it in.
                    * Save your pre-commit hook in .hooks/pre-commit
                    * Use the usual git operations, forget about that pesky Cmd-U, rake or xctool.
                    * When sharing code, new team members automatically get the pre-commit hooks.
                   DESC
  s.homepage     = "http://mickeyreiss.github.io/pre-commit"
  s.license      = 'MIT'
  s.author       = { "Mickey Reiss" => "mickeyreiss@gmail.com" }
  s.source       = { :git => "http://github.com/mickeyreiss/pre-commit.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.source_files = ''

  s.prepare_command = <<-CMD
    GIT_PRECOMMIT_SCRIPT=.git/hooks/pre-commit
    MY_PRECOMMIT_SCRIPT=.hooks/pre-commit
    if [[ -f ${GIT_PRECOMMIT_SCRIPT} ]]; then
      echo "Error: the pre-commit pod will not override the existing pre-commit hook at '${GIT_PRECOMMIT_SCRIPT}'. To fix this, remove the script (\\`rm ${GIT_PRECOMMIT_SCRIPT}\\`) or delete this pod from your Podfile." >&2
      exit 1
    elif [[ ! -x ${MY_PRECOMMIT_SCRIPT} ]]; then
      if [[ -h ${GIT_PRECOMMIT_SCRIPT} ]]; then
        rm ${GIT_PRECOMMIT_SCRIPT}
      fi
      echo "Error: the pre-commit pod expects to find an executable script at '${MY_PRECOMMIT_SCRIPT}', but none was found. To fix this, add the script and make sure it is executable (\\`chmod +x ${MY_PRECOMMIT_SCRIPT}\\`)." >&2
      exit 2
    fi

    ln -fs ${MY_PRECOMMIT_SCRIPT} ${GIT_PRECOMMIT_SCRIPT}
  CMD
end

