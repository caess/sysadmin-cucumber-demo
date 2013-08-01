Feature: Editors on the VMs
  As the author of a blog post
  I want all standard editors to be on the VMs
  So that readers may use their editor of choice when they use the demo environment

  Scenario Outline: vi
    When I run the command "vi --version" on the "<vm>" VM
    Then I should see this in the output:
      """
      VIM - Vi IMproved 7.2 (2008 Aug 9, compiled Apr  5 2012 10:13:12)
      """

    Scenarios:
      |vm|
      |tester|
      |dns_master|
      |dns_slave1|
      |dns_slave2|

  Scenario Outline: vim
    When I run the command "vim --version" on the "<vm>" VM
    Then I should see this in the output:
      """
      VIM - Vi IMproved 7.2 (2008 Aug 9, compiled Apr  5 2012 10:12:47)
      """

    Scenarios:
      |vm|
      |tester|
      |dns_master|
      |dns_slave1|
      |dns_slave2|

  Scenario Outline: emacs
    When I run the command "emacs --version" on the "<vm>" VM
    Then I should see this in the output:
      """
      GNU Emacs 23.1.1
      """

    Scenarios:
      |vm|
      |tester|
      |dns_master|
      |dns_slave1|
      |dns_slave2|

  Scenario Outline: nano
    When I run the command "nano -V" on the "<vm>" VM
    Then I should see this in the output:
      """
      GNU nano version 2.0.9 (compiled 07:14:41, Nov 12 2010)
      """

    Scenarios:
      |vm|
      |tester|
      |dns_master|
      |dns_slave1|
      |dns_slave2|