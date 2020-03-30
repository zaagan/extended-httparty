# extended-httparty

An extension to **[HTTParty](https://github.com/jnunemaker/httparty)** ( Adds Retry capabilities).

Retries HTTP request upto 3 times by default in case of failures and timeouts.




**Default Trials :** 3

**Default Sleep Interval :** 3 seconds




## Pre-requisites

Install [HTTParty](https://github.com/jnunemaker/httparty).

```bash
 gem install httparty
```





## How It Works

Does everything that HTTParty does. 

All you got to do is replace the name from **HTTParty** to **ExtendedHttparty**.

**From :**

```ruby
response = HTTParty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')
```

**To :**

```ruby
response = ExtendedHttparty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')
```




## Update Trials

You can update the number of trials by passing an integer value as the parameter.

```ruby
response = ExtendedHttparty.get('your-url', tries: 5)
```



## References

- [httparty-retry](https://github.com/mdoyle13/httparty-retry)


