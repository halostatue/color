# Contributing

I value any contribution to Color you can provide: a bug report, a feature
request, or code contributions.

There are a few guidelines for contributing to Color:

- Changes _will not_ be accepted without tests. The test suite is written with
  [minitest][].
- We use [standardrb][] for code formatting.
- Use a thoughtfully-named topic branch that contains your change. Rebase your
  commits into logical chunks as necessary.
- Use [quality commit messages][].
- Do not change the version number; when your patch is accepted and a release
  is made, the version will be updated at that point.
- Submit a GitHub pull request with your changes.
- New or changed behaviours require new or updated documentation.

### Test Dependencies

Color uses Ryan Davis’s excellent [Hoe][] to manage the release process, and it
adds a number of rake tasks. You will mostly be interested in `rake`, which runs
the tests the same way that `rake test` does.

To assist with the installation of development dependencies for Color, I have
provided the simplest possible Gemfile pointing to the (generated)
`color.gemspec` file. This will permit you to `bundle install` the dependencies.

## Workflow

Here's the most direct way to get your work merged into the project:

- Fork the project.
- Clone down your fork (`git clone git://github.com/<username>/color.git`).
- Create a topic branch to contain your change (`git checkout -b my_awesome_feature`).
- Hack away, add tests. Not necessarily in that order.
- Make sure everything still passes by running `rake`.
- If necessary, rebase your commits into logical chunks, without errors.
- Push the branch up (`git push origin my_awesome_feature`).
- Create a pull request against halostatue/color and describe what your change
  does and the why you think it should be merged.

=== Contributors

- Austin Ziegler created color-tools.
- Matt Lyons created color.
- Dave Heitzman (contrast comparison)
- Thomas Sawyer
- Aaron Hill (CIE94 colour matching)
- Luke Bennellick
- Matthew Draper

[hoe]: https://github.com/seattlerb/hoe
[minitest]: https://github.com/seattlerb/minitest
[quality commit messages]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[standardrb]: https://github.com/testdouble/standard
