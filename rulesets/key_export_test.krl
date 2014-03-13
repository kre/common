ruleset key_export_test {

  meta {
    name "key export test "
    description <<
Tests that keys exported to a144x72 aren't exported to this module just because it uses a144x72
>>
    author "PJW"
    logging off
    use module a144x172
    key a "local key"
  }

  global {
     a_me = keys:a();
     b_me = keys:b();
  }

}