package { 'foreman':
  ensure   => present,
  provider => gem,
}
->
package { 'bundler':
  ensure   => present,
  provider => gem,
}
->
package { 'git': }
->
package { 'ruby-dev': }
->
package { 'build-essential': }
->
package { 'libpq-dev': }
->
package { 'libmysqlclient-dev': }
->
package { 'libsqlite3-dev': }
->
package { 'nodejs': }
