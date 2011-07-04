using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace RSS.Models
{
    public class NewUserFeedModel
    {
        public Guid UserId { get; set; }

        [Required]
        [Display(Name = "Feed name")]
        [DataType(DataType.Text)]
        public string Name { get; set; }
        
        [Required]
        [Display(Name = "Feed description")]
        [DataType(DataType.MultilineText)]
        [MaxLength(140,ErrorMessage = "Too long")]
        public string Description { get; set; }

        //[Required]
        //[Display(Name = "Rss feeds")]
        //[DataType(DataType.Text)]
        //public IEnumerable<RssFeed> RssFeeds { get; set; }

        [Required]
        [Display(Name = "Tags")]
        [DataType(DataType.Text)]
        public string Tags { get; set; }

        [Display(Name = "Filter")]
        [DataType(DataType.Text)]
        public string FilterText { get; set; }

        [Required]
        [Display(Name = "Is public")]
        public bool IsPublic { get; set; }

        [Required]
        [Display(Name = "Is favourite")]
        public bool IsFavourite { get; set; }
    }
}