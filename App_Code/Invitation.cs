using System;
using System.Runtime.Serialization;

namespace Peashakehouse
{
    [DataContract]
    public class Invitation
    {
        [DataMember(Name = "text")]
        public string Text { get; set; }

        [DataMember(Name = "chatId")]
        public Guid ChatID { get; set; }

        [DataMember(Name = "from")]
        public string From { get; set; }
    }
}
