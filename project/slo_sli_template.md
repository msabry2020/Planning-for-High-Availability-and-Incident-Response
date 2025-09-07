# API Service

| Category     | SLI                                                                                        | SLO                                            |
|--------------|--------------------------------------------------------------------------------------------|------------------------------------------------|
| Availability | Total number of successful requests / total number of requests for the (over 5 min) > 99%  | 99%                                            |
| Latency      | Histogram buckets of the 90th percentile (over 5 minutes) < 100 ms                         | 90% of requests below 100ms                    |
| Error Budget | 100% - % Successful requests/Total requests (over 1 day) < 20%                             | Error budget is defined at 20%.                |
| Throughput   | Total number of successful requests per second (over 5 minutes) > 5                        | 5 RPS indicates the application is functioning |
