# Contributing

First, thank you for contributing!

Here a few guidelines to follow:

1. Open an [issue][issues] to discuss a new feature.
1. Write tests.
1. Make sure the entire test suite passes locally and on Travis CI.
1. Open a Pull Request.
1. [Squash your commits][squash] after receiving feedback.
1. Party!

[issues]: https://github.com/thoughtbot/hound/issues
[squash]: https://github.com/thoughtbot/guides/tree/master/protocol/git#write-a-feature

## Configure Hound on Your Local Development Environment

1. After cloning the repository, run the setup script `./bin/setup`
1. Point [ngrok] to your local Hound instance:
   `ngrok -subdomain=<your-initials>-hound 5000`
1. Set the `HOST` variable in your `.env` to your ngrok host. Note the setup script
   copies `.sample.env` to `.env` for you, if the file does not exist.
1. Log into your GitHub account and go to the
   [Applications under Personal settings](https://github.com/settings/applications).
1. Under the Developer applications panel - Click on "Register new
   application"
1. Fill in the application details:
  * Application Name: Hound Development
  * Homepage URL: `http://<your-initials>-hound.ngrok.com`
  * Authorization Callback URL: `http://<your-initials>-hound.ngrok.com`
1. On the confirmation screen, copy the `Client ID` and `Client Secret` to `.env`.
1. Next click "Generate new token" and fill in token details:
  * Token description: Hound Development
  * Select scopes: `repo` and `user:email`
1. On the confirmation screen, copy the generated token to `.env`.
1. Run `foreman start`. Foreman will start the web server and
   the resque background job queue. NOTE: `rails server` will not load the
   appropriate environment variables and you'll get a "Missing `secret_key_base`
   for 'development' environment" error.

[ngrok]: https://ngrok.com

## Testing

1. Set up your `development` environment as per above.
1. Run `rake` to execute the full test suite.

To test Stripe payments on staging use this fake credit card number.

<table>
  <thead>
    <tr>
      <th>Card</th>
      <th>Number</th>
      <th>Expiration</th>
      <th>CVV</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Visa</td>
      <td>4242424242424242</td>
      <td>Any future date</td>
      <td>Any 3 digits</td>
    </tr>
  </tbody>
</table>

## Contributor License Agreement

If you submit a Contribution to this application's source code, you hereby grant
to thoughtbot, inc. a worldwide, royalty-free, exclusive, perpetual and
irrevocable license, with the right to grant or transfer an unlimited number of
non-exclusive licenses or sublicenses to third parties, under the Copyright
covering the Contribution to use the Contribution by all means, including but
not limited to:

* to publish the Contribution,
* to modify the Contribution, to prepare Derivative Works based upon or
  containing the Contribution and to combine the Contribution with other
  software code,
* to reproduce the Contribution in original or modified form,
* to distribute, to make the Contribution available to the public, display and
  publicly perform the Contribution in original or modified form.
