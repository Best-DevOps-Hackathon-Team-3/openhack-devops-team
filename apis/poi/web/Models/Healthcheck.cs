using System;
using Newtonsoft.Json;

namespace poi.Models
{
    public class Healthcheck
    {
        public Healthcheck()
        {
            Message = "POI Service Healthcheck";
            Status = "Healthy";
            TestMessage = "This is a test message doing an auto swap.";
        }
        [Newtonsoft.Json.JsonProperty(PropertyName = "message")]
        public string Message {get;set;}

        [Newtonsoft.Json.JsonProperty(PropertyName = "status")]
        public string Status { get; set; }
        
        [Newtonsoft.Json.JsonProperty(PropertyName = "testMessage")]
        public string TestMessage { get; set; }
    }
}
